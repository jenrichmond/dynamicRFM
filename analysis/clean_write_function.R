# Turn that single file cleaning pipe into a function

cleanwrite_emg <- function(data) { 
  data %>% remove_empty(which = "cols") %>%
    select(-4, -7, -10, -13, -16, -19, -22) %>%
    rename(bin = ...1, 
           trial1_brow = µV...2, 
           trial1_cheek = µV...3, 
           trial2_brow = BROW_DF...6,
           trial2_cheek = CHEEK_DF...7, 
           trial3_brow = BROW_DF...10, 
           trial3_cheek = CHEEK_DF...11, 
           trial4_brow = BROW_DF...14, 
           trial4_cheek = CHEEK_DF...15,
           trial5_brow = BROW_DF...18,
           trial5_cheek = CHEEK_DF...19,
           trial6_brow = BROW_DF...22,
           trial6_cheek = CHEEK_DF...23, 
           trial7_brow = BROW_DF...26, 
           trial7_cheek = CHEEK_DF...27,
           trial8_brow = BROW_DF...30, 
           trial8_cheek = CHEEK_DF...31) %>%
    mutate(bin = c("bin_0", 
                   "bin_1", 
                   "bin_2", 
                   "bin_3", 
                   "bin_4", 
                   "bin_5", 
                   "bin_6")) %>%
    mutate(bin_no = 0:6) %>%
    select(file_name, bin, bin_no, contains("trial")) %>%
    pivot_longer(cols = 4:19, 
                 names_to = c("trial", "muscle"), 
                 names_sep = "_",
                 values_to = "rms") %>%
    arrange(trial, bin_no) %>%
    write_csv(here("data", "clean", path = paste0("clean_", unique(.$file_name),".csv")))
  
}