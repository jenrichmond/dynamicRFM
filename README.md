# dynamicRFM

A [workflowr][] project.

[workflowr]: https://github.com/jdblischak/workflowr


# README

All the dynamic data files are in the data/dirty. Scripts that were created in the working out process are in the "working" folder, those that made the cut into the final cleaning process are in the "final" folder. 

The cleaning process is documented below. 

## Step 1 - work out cleaning process on a single file

I read in a single dirty file and wrote a script (scripts/working/clean1file.R) that selects just the needed columns, renames them, adds a bin column, makes the data long and writes it to csv using the filename. 

## Step 2 - convert to a clean_write function

I turned the cleaning process into a function called cleanwrite_emg() (scripts/final/clean_write_function.R)

## Step 3- read in all dirty files, clean and write to csv

Use 1_map_clean_dynamic files.Rmd to read all the dirty excel files into a list, and add a file_name variable, using map and read_excel. Then run the cleanwrite_emg on all of the files. This runs the cleaning process on each file and writes it to csv in the clean folder. 

## Step 4 - combine all clean files into single df

Use 2_bind clean files.Rmd read all the clean csvs into a single dataframe, separate filename into pp_no, condition, emotion, write to csv. 

## Step 5 - identify baseline outliers, exclude whole trials

Use 3_baselineoutliers.Rmd to read in the clean_combined.csv data, create separate data frames for baseline (bin = 0) and stimulus. In bl_df add mean and sd column by participant, emotion, muscle and then logical variable that screens each baseline TRUE/FALSE depending on whether each rms value is more than 1.5sd above the mean. Count how many trials for each participant have bad baseline, then bind bl and stim back together. Filter out trials that have bad baseline, and write to csv (clean_no_bl_outliers.csv). 

## Step 6 - calculate z scores

Use 4_calculating z scores, to make muscle wide, then calc Zbrow and cheek for each participant. For each muscle separtely, make bin wide, then calc difference scores (bin1-BL). Drop extra columns and make the data long again. Combine cheek and brow with bind_rows, write to csv 4_zdiff_clean.csv. 

## Step 7 - bin outliers

Use 5_bin_outliers.RMD to read in zdiff_clean.csv and mutate new variables for meanZdiff and sdZdiff separately for each participant and trial. Make new logical test, TRUE if the bin value > 2SD mean, then use mutate and replace() to replace individual bin values with NA if they are outliers. Drop extra columns and write to csv (5_zdiff_binscreened.csv)

## Step 8 - plots

Use 6_plotting.rmd to read in 5_zdiff_binscreened.csv and plot muscle activity across bins, separately for brow and cheek, in response to happy, angry, sad, and fear.

## Step 9 - analysis


