# install.packages("ggplot2")
library(ggplot2)
BiocManager::install("ggtree")
library(ggtree)
library(treeio)
library(TDbook)


# prettier labels
tree_alrt_abayes_ufb <- read.tree("clustalo_not_trimmed_iqtree_bootstrap.treefile")
label <- tree_alrt_abayes_ufb$node.label
alrt <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 1))
abayes <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 2))
ufb <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 3))

ufb[1] <- ""
abayes[1] <- ""
alrt[1] <- ""

large_alrt <- ifelse(alrt > 70, "*", "")
large_abayes <- ifelse(abayes > 0.7, "&", "")
large_ufb <- ifelse(ufb > 95, "@", "")

newlabel <- paste0(large_alrt, large_abayes, large_ufb)
tree_alrt_abayes_ufb$node.label <- newlabel

ggtree(tree_alrt_abayes_ufb) + 
  geom_tiplab() + geom_nodelab(label = ufb) +
  geom_treescale() + xlim(0, 1.4)

library(treeio)
library(ggplot2)
library(ggtree)
library(TDbook)

tree_alrt_abayes_ufb <- read.tree("clustalo_not_trimmed_iqtree_bootstrap.treefile")
label <- tree_alrt_abayes_ufb$node.label
EC1 <- which(tree_alrt_abayes_ufb$tip.label == "AT1G76750.1_Arabidopsis_thaliana")
EC2 <- which(tree_alrt_abayes_ufb$tip.label == "AT2G21740.1_Arabidopsis_thaliana")
EC3 <- which(tree_alrt_abayes_ufb$tip.label == "AT2G21750.1_Arabidopsis_thaliana")
EC4 <- which(tree_alrt_abayes_ufb$tip.label == "AT4G39340.1_Arabidopsis_thaliana")

branches <- list(EC1=EC1,EC2=EC2)
tree_alrt_abayes_ufb <- groupOTU(tree_alrt_abayes_ufb,branches)


ufb <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 1))
ufb <- c(NA, ufb)

# ufb <- c(1, ufb)
# ufb <- rep(ufb, each=2)
ufb <- c(ufb, ufb)
root <- rootnode(tree_alrt_abayes_ufb)  
length(ufb)

tree_pic <- ggtree(tree_alrt_abayes_ufb, color="black", size=0.5, linetype=1,  right=TRUE) + 
  geom_tiplab(aes(color=group), size=1.5, hjust = -0.060, align=T, linesize=0.3) +  xlim(0, 15) +
  # geom_hilight(node=202, fill="blue", alpha=0.3, extendto=5.63) +
  geom_hilight(node=206, fill="blue", alpha=0.3, extendto=6.15) +
  geom_hilight(node=264, fill="#B589D6", alpha=0.3, extendto=6.15) +
  geom_point2(aes(subset=!isTip & node != root, 
                  fill=cut(ufb, c(0, 70, 90, 100))), 
              shape=21, size=2) + 
  theme_tree(legend.position=c(0.85, 0.96)) +
  scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
                    name='Bootstrap Percentage', 
                    breaks=c('(90,100]', '(70,90]', '(0,70]'), 
                    labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) +
  scale_color_manual(values=c("black", "orange", "orange"), guide="none") 


ggsave("tree.png",tree_pic, height = 12, width= 5)


# branches <- list(EC1=EC1,EC2=EC2,EC3=EC3,EC4=EC4)
# tree_alrt_abayes_ufb <- groupOTU(tree_alrt_abayes_ufb,branches)
# 
# 
# ufb <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 3))
# ufb <- rep(ufb, each=2)
# ufb <- c(ufb, ufb)
# root <- rootnode(tree_alrt_abayes_ufb)  
# length(ufb)
# 
# ggtree(tree_alrt_abayes_ufb, color="black", size=0.5, linetype=1,  right=TRUE) + 
#   geom_tiplab(aes(color=group), size=1.5, hjust = -0.060) +  xlim(0, 15) +
#   geom_hilight(node=206, fill="#804FB3", alpha=0.3, extendto=5.63) +
#   geom_hilight(node=264, fill="#B589D6", alpha=0.3, extendto=8) +
#   geom_point2(aes(subset=!isTip & node != root, 
#                   fill=cut(ufb, c(0, 70, 90, 100))), 
#               shape=21, size=2) + 
#   theme_tree(legend.position=c(0.5, 0.7)) + 
#   scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
#                     name='Bootstrap Percentage(BP)', 
#                     breaks=c('(90,100]', '(70,90]', '(0,70]'), 
#                     labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) +
#   scale_color_manual(values=c("black", "green", "green", "red", "red")) 


ggtree(tree_alrt_abayes_ufb, aes(color=group), size=0.5, linetype=1,  right=TRUE) + 
  geom_tiplab(aes(color=group), size=1.5, hjust = -0.060) +  xlim(0, 15) +
  geom_hilight(node=206, fill="#804FB3", alpha=0.3, extendto=5.63) +
  geom_hilight(node=264, fill="#B589D6", alpha=0.3, extendto=8) +
  geom_point2(aes(subset=!isTip & node != root, 
                  fill=cut(ufb, c(0, 70, 90, 100))), 
              shape=21, size=2) + 
  theme_tree(legend.position=c(0.5, 0.9)) + 
  scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
                    name='Bootstrap Percentage(BP)', 
                    breaks=c('(90,100]', '(70,90]', '(0,70]'), 
                    labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) +
  scale_color_manual(values=c("black", "#804FB3", "#B589D6"), guide="none")

