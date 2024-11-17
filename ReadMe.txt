### Date : March 14 2024
### Written by Jangwoo Lee, PhD (University of Calgary, jangwoo.lee@ucalgary.ca)
### Related Manuscript : Lee et al., 2024 Communications Medicine, Accepted
### Doi (for this code) : https://doi.org/10.5281/zenodo.14176036

### Description
The workflow (*Example_Run_v2.R & *Permutation_v2.R), proposed in this study, enables 
(1) to calculate the median of dissimilarity distances among 28 randomly selected pairs comparing two different human development index (HDI) categories (e..g, H:H, H:UM, ...), then compare with that among 8 Calgary neighborhoods (CGY:CGY)
(2) to repeat aforementioned step for 100 times, then calculate p-value, according to (Eq.6) shown in the manuscript

For details, plase see Fig. 5 and/or the section Methods: Monte-Carlo Permutation Simulation, in the manuscript.

### Files:
(1) distance.matrix.results_v9.2_SES_Updated.csv : This file is a raw input dataset, containing dissimilarity distance (calculated using Bray-Curtis metrics) between two nodes (node1 vs node2), also detailed information for each node. For example, 'node1.detail (or node2.detail)' column, indicating whether the sample for node1 (or node2) originated from this study or other studies. In addition, 'node1.HDI (or node2.HDI)' column indicates the category (high (H), upper middle (UM), lower middle (LM), or low (L)) of HDI that the sample for node1 (or node2) represented. 

(2) 1. Global_WBE_Metagenomics_Dissimilarity_Comparison_HDI_An_Example_Run_v2.R : This code is designed to calculate a permutation run - comparing the median dissimilarity index among 28 sandomely selected pairs comparing different HDI categories with that among 8 Calgary neighborhoods.

(3) 2. Global_WBE_Metagenomics_Dissimilarity_Comparison_HDI_Permutation_v2.R : This code implements repetition of the previous step (see 1. Global_WBE_Metagenomics_Dissimilarity_Comparison_HDI_An_Example_Run_v2.R) for 100 times, then calculate p-value.
