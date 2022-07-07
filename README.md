full do.do is a compilation of the three other files, which I broke apart for debugging purposes, then reassembled into this file for the final product so I didn't need a main/make file as I was tinkering with my data sets.
To preprocess this data, which was pulled from the Bureau of Labor Statistics Occupational Employment and Wage survey, I dropped all data with an ownership code other than 5, meaaning I kept only data pertaining to privately-owned businesses, not owned by international, federal, state, or local governments, as government employers face different incentives from private ones, and these businesses might have distorted my findings. I then dropped all the data which was irrelevant to my paper, leaving me with only the industry code (denoting which industry I was examining), the industry title (the plain-text name of the industry, which was important for later data visualizations), and the year-over-year changes in wages and employment, my variables of direct interest. I dropped all data with an industry code length other than 4, which I determined to be the appropriate level of granularity for the purposes of this project\\*.




\\*BLS industry codes 
