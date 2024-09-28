#!/usr/bin/env python3

# Script per filtrare un multifasta basato su una lista di intestazioni da rimuovere
# Utilizzo: python filter_fasta_by_list_of_headers.py input.fasta list_of_scf_to_filter > filtered.fasta

from Bio import SeqIO
import sys

# Carica il file FASTA
ffile = SeqIO.parse(sys.argv[1], "fasta")

# Carica l'elenco delle intestazioni da rimuovere
header_set = set(line.strip() for line in open(sys.argv[2]))

# Cicla attraverso ogni record nel FASTA
for seq_record in ffile:
    try:
        # Rimuovi l'intestazione se esiste nell'elenco
        header_set.remove(seq_record.name)
    except KeyError:
        # Stampa la sequenza senza spazi vuoti tra le sequenze
        print(seq_record.format("fasta").strip())
        continue

# Messaggio di errore se ci sono intestazioni non trovate nel file
if len(header_set) != 0:
    print(len(header_set), 'of the headers from list were not identified in the input fasta file.', file=sys.stderr)
