# Installing packages if required
cran_packages <- c("ggplot2", "TDbook") 
package.check <- lapply(
  cran_packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

if (!require("ggtree"))
  BiocManager::install("ggtree")
if (!require("treeio"))
  BiocManager::install("treeio")

path_to_folder = "~/Documents/EC_genes_BI_Project_2022/Phylogenetic_analysis"
setwd(path_to_folder)
# Reading the tree
tree_alrt_abayes_ufb <- read.tree("clustalo_not_trimmed_iqtree_bootstrap.treefile")
label <- tree_alrt_abayes_ufb$node.label
EC1 <- which(tree_alrt_abayes_ufb$tip.label == "AT1G76750.1_Arabidopsis_thaliana")
EC2 <- which(tree_alrt_abayes_ufb$tip.label == "AT2G21740.1_Arabidopsis_thaliana")
# If we want to visualize EC1.3 and EC1.4 as well
# EC3 <- which(tree_alrt_abayes_ufb$tip.label == "AT2G21750.1_Arabidopsis_thaliana")
# EC4 <- which(tree_alrt_abayes_ufb$tip.label == "AT4G39340.1_Arabidopsis_thaliana")

branches <- list(EC1=EC1,EC2=EC2) # Add the EC1.3 and EC1.4 here if you want to visualize them
tree_alrt_abayes_ufb <- groupOTU(tree_alrt_abayes_ufb,branches) # Creating groups

# We have 3 values for bootstrap - 1 - aBayes, 2 - SH-aLRT, 3 - ultrafast
# We take ultrafast
ufb <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 3))
ufb <- c(NA, ufb)
ufb <- c(ufb, ufb)
# Take root
root <- rootnode(tree_alrt_abayes_ufb)  

# Rectangular tree for the final defense

tree_pic <- ggtree(tree_alrt_abayes_ufb, color="black", size=0.5, linetype=1,  right=TRUE) + # Draw tree
  geom_tiplab(aes(color=group), size=1.5, hjust = -0.060, align=T, linesize=0.3) + # Color the tips according to groups (EC red), align them on one linze 
  scale_color_manual(values=c("black", "orange", "orange"), guide="none") + # Visuals of tip labels
  xlim(0, 15) + # Limit to the length of the branch
  # geom_hilight(node=202, fill="blue", alpha=0.3, extendto=5.63) +
  geom_hilight(node=206, fill="blue", alpha=0.3, extendto=6.15) + # Highlight EC1.1 clade
  geom_hilight(node=264, fill="#B589D6", alpha=0.3, extendto=6.15) + # Highlight EC1.2 clade
  geom_point2(aes(subset=!isTip & node != root, 
                  fill=cut(ufb, c(0, 70, 90, 100))), 
                  shape=21, size=2) + # Create points for bootstrap values
  scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
                    name='Bootstrap Percentage', 
                    breaks=c('(90,100]', '(70,90]', '(0,70]'), 
                    labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) + # Visuals of bootstrap values
  theme_tree(legend.position=c(0.85, 0.96)) 


ggsave("tree_rectangular.png",tree_pic, height = 12, width= 5)


# Circular tree with branch length

ggtree(tree_alrt_abayes_ufb, color="black", size=0.5, linetype=1,  right=TRUE) + 
  layout_circular() + 
  geom_tiplab(aes(color=group), size=1.5, hjust = -0.060, align=T, linesize=0.1) +  xlim(0, 15) +
  geom_hilight(node=206, fill="blue", alpha=0.3,  extendto=6.15) +
  geom_cladelabel(node=206, label="EC 1.1", color="blue", offset.text = 1, fontsize = 5, barsize = 1)+
  geom_hilight(node=264, fill="#B589D6", alpha=0.3,  extendto=6.15) +
  geom_cladelabel(node=264, label="EC 1.2", color="#8D45A1", offset = -2, offset.text = 0.5, fontsize = 5, barsize = 1)+
  
  geom_point2(aes(subset=!isTip & node != root, 
                  fill=cut(ufb, c(0, 70, 90, 100))), 
              shape=21, size=2) + 
  theme_tree(legend.position=c(0.85, 0.96)) +
  scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
                    name='Bootstrap Percentage', 
                    breaks=c('(90,100]', '(70,90]', '(0,70]'), 
                    labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) +
  scale_color_manual(values=c("black", "red", "red"), guide="none") 


# Put back into function
ggtree(tree_alrt_abayes_ufb, color="black", size=0.5, linetype=1,  right=TRUE, branch.length='none') + 
  layout_circular() + 
  geom_tiplab(aes(color=group), size=5, hjust = -0.060, align=T, linesize=0.1) +  
  geom_hilight(node=node_1, fill="blue", alpha=0.3,  extendto=6.15) +
  geom_cladelabel(node=node_1, label="EC1.1", color="#0000FF", offset=offset_1, offset.text = -1.5, fontsize = 15, barsize = 1, geom='label', fill='#a3a3f7')+
  geom_hilight(node=node_2, fill="#B589D6", alpha=0.3,  extendto=6.15) +
  geom_cladelabel(node=node_2, label="EC1.2", color="#8D45A1", offset = offset_2, offset.text = -0.5, fontsize = 15, barsize = 1, geom='label',  fill='#dba2eb')+
  geom_point2(aes(subset=!isTip & node != root, 
                  fill=cut(ufb, c(0, 70, 90, 100))), 
              shape=21, size=10) + 
  theme_tree(legend.position=c(0.9, 0.9)) +
  theme(legend.title=element_text(size=30, face='bold'), 
        legend.text=element_text(size=25)) +
  scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
                    name='Bootstrap Percentage', 
                    breaks=c('(90,100]', '(70,90]', '(0,70]'), 
                    labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) +
  scale_color_manual(values=c("black", "red", "red"), guide="none") 


# Define function to draw tree picture without branch length and save it
save_tree_without_branchlength <- function(input_file, output_file, node_1, node_2, offset_1, offset_2) {
  # Read tree
  tree_alrt_abayes_ufb <- read.tree(input_file)
  
  # Read labels (bootstrap values)
  # We have 3 values for bootstrap - 1 - aBayes, 2 - SH-aLRT, 3 - ultrafast
  # We take ultrafast
  label <- tree_alrt_abayes_ufb$node.label
  ufb <- as.numeric(sapply(strsplit(label, "/"), FUN = "[", 3))
  ufb <- c(NA, ufb)
  ufb <- c(ufb, ufb)
  
  # Find the labels of EC1 genes and create groups
  EC1 <- which(tree_alrt_abayes_ufb$tip.label == "AT1G76750.1_Arabidopsis_thaliana")
  EC2 <- which(tree_alrt_abayes_ufb$tip.label == "AT2G21740.1_Arabidopsis_thaliana")
  branches <- list(EC1=EC1,EC2=EC2)
  tree_alrt_abayes_ufb <- groupOTU(tree_alrt_abayes_ufb,branches)
  
  # Take root of the tree
  root <- rootnode(tree_alrt_abayes_ufb)  

  # Without branch length, because one branch tooo long
  tree_pic_without_branch_length <- ggtree(tree_alrt_abayes_ufb, color="black", size=0.5, linetype=1,  right=TRUE, branch.length='none') + 
    layout_circular() + 
    geom_tiplab(aes(color=group), size=5, hjust = -0.060, align=T, linesize=0.1) +  
    geom_hilight(node=node_1, fill="blue", alpha=0.3,  extendto=6.15) +
    geom_cladelabel(node=node_1, label="EC1.1", color="#0000FF", offset=offset_1, offset.text = -1.5, fontsize = 15, barsize = 1, geom='label', fill='#a3a3f7')+
    geom_hilight(node=node_2, fill="#B589D6", alpha=0.3,  extendto=6.15) +
    geom_cladelabel(node=node_2, label="EC1.2", color="#8D45A1", offset = offset_2, offset.text = -0.5, fontsize = 15, barsize = 1, geom='label',  fill='#dba2eb')+
    geom_point2(aes(subset=!isTip & node != root, 
                    fill=cut(ufb, c(0, 70, 90, 100))), 
                shape=21, size=10) + 
    theme_tree(legend.position=c(0.9, 0.9)) +
    theme(legend.title=element_text(size=30, face='bold'), 
          legend.text=element_text(size=25)) +
    scale_fill_manual(values=c("white", "grey", "black"), guide='legend', 
                      name='Bootstrap Percentage', 
                      breaks=c('(90,100]', '(70,90]', '(0,70]'), 
                      labels=expression(BP>=90,70 <= BP * " < 90", BP < 70)) +
    scale_color_manual(values=c("black", "red", "red"), guide="none") 
  
  ggsave(output_file, tree_pic_without_branch_length, height = 48, width= 45)
  
  
}

# Circular tree picture without branch length for GitHub
save_tree_without_branchlength("clustalo_not_trimmed_iqtree_bootstrap.treefile", "tree_without_branch_length.png", 206, 264, -16.5, -17.5)

# Save the gappyout trimmed trees the same way
save_tree_without_branchlength("clustalo_gappyout_trimmed_iqtree_bootstrap.treefile", "gappyout_trimmed_tree_without_branch_length.png", 366, 256, -10.5, -17.5)

# Save the gappyout trimmed trees the same way
save_tree_without_branchlength("clustalo_strict_trimmed_iqtree_bootstrap.treefile", "strict_trimmed_tree_without_branch_length.png", 355, 245, -11.5, -19.5)

