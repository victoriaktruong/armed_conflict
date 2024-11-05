library(ggplot2)
library(dplyr)
library(corrplot)
library(FactoMineR)
library(factoextra)
library(here)

# Read in the data
data <- read.csv(here("original","analytical", "finaldata.csv"),header=TRUE)

# View first few rows of dataset
head(data)

# Summary statistics
summary(data)

# Remove missing rows
clean_data <- na.omit(data)

# Produce a correlation matrix 
numeric_data <- clean_data %>% select_if(is.numeric)
cor_matrix <- cor(numeric_data, use = "complete.obs")
corrplot(cor_matrix, method = "square")

# PCA - Principal Component Analysis
# Standardize the numeric data before PCA
scaled_data <- scale(numeric_data)


# Performing PCA
pca_result <- PCA(scaled_data, graph = FALSE)

# Generate a Scree plot
fviz_eig(pca_result)


# Create a biplot with only arrows (variables)
fviz_pca_var(pca_result, 
             col.var = "steelblue",  
             repel = TRUE,           
             labelsize = 4)





