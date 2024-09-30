### Branch Lengths Comparisons

library(ape)
nucox_tree<-read.tree("nucOXPHOS_BranchLengths.txt")
mt_tree<-read.tree("mtOXPHOS_BranchLength.txt")
busco_tree<-read.tree("BUSCO_BranchLengths.txt")

library(adephylo)
mt_tree_distances<-distRoot(mt_tree,tips="all",method="patristic")
nucox_tree_distances<-distRoot(nucox_tree,tips="all",method="patristic")
busco_tree_distances<-distRoot(busco_tree,tips="all",method="patristic")

mt_tree_distances<-data.frame(mt_tree_distances)
nucox_tree_distances<-data.frame(nucox_tree_distances)
busco_tree_distances<-data.frame(busco_tree_distances)

mt_tree_distances<-mt_tree_distances[order(rownames(mt_tree_distances)), , drop = FALSE]
nucox_tree_distances<-nucox_tree_distances[order(rownames(nucox_tree_distances)), , drop = FALSE]
busco_tree_distances<-busco_tree_distances[order(rownames(busco_tree_distances)), , drop = FALSE]

mt_distnorm<-mt_tree_distances/sum(mt_tree_distances)
nucox_distnorm<-nucox_tree_distances/sum(nucox_tree_distances)
busco_distnorm<-busco_tree_distances/sum(busco_tree_distances)

dataset_distnorm<-cbind(mt_distnorm,nucox_distnorm,busco_distnorm)

indici_ordinati <- match(busco_tree$tip.label, rownames(dataset_distnorm))
dataset_distnorm_ordinato <- dataset_distnorm[indici_ordinati, ]

par(mar = c(10,5,2,2))

#Plot
plot(dataset_distnorm_ordinato$mt_tree_distances, 
     pch = 19,
     cex = 1.5,
     col = "black", 
     xlab = "",
     xaxt = "n",
     ylab = "Scaled Branch Lengths",
     cex.axis = 1) 

#Add poitns
points(dataset_distnorm_ordinato$nucox_tree_distances, 
       pch = 19, 
       col = "black", 
       cex = 1.5)    

points(dataset_distnorm_ordinato$mt_tree_distances, 
       pch = 19, 
       col = "goldenrod1", 
       cex = 1.3)    

points(dataset_distnorm_ordinato$busco_tree_distances, 
       pch = 19, 
       col = "black", 
       cex = 1.5)    

#Add dots
points(dataset_distnorm_ordinato$nucox_tree_distances, 
       pch = 19, 
       col = "darkslategray4", 
       cex = 1.3)        
points(dataset_distnorm_ordinato$busco_tree_distances, 
       pch = 19, 
       col = "#CCCCCC", 
       cex = 1.3)          

#Link mtOXPHOS and nucOXPHOS
for (i in 1:nrow(dataset_distnorm_ordinato)) {
    lines(x = c(i, i), 
          y = c(dataset_distnorm_ordinato$mt_tree_distances[i], dataset_distnorm_ordinato$nucox_tree_distances[i]),
          col = "grey43")
}

legend("bottomright", 
       legend = c("mtOXPHOS", "nucOXPHOS", "BUSCO"), 
       pch = 19, 
       cex = 1.2,
       pt.cex = 1.3,
       col = c("goldenrod1", "darkslategray4", "#CCCCCC"),
       bg = "white",
       bty = "o",
       xjust = 1,
       yjust = 1,
       inset = c(0.01, 0.01))  

#Add species name
axis(1, at = 1:length(dataset_distnorm_ordinato$mt_tree_distances), 
     labels = rownames(dataset_distnorm_ordinato), font.axis = 3, las =2,
     cex.axis = 0.8)  

#Add vertical lines
abline(v = seq(0.5, length(dataset_distnorm_ordinato$mt_tree_distances) + 0.5), col = "black", lty = "dotted")




