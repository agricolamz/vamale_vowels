setwd("/home/agricolamz/work/articles/2022_Vamale/repo/")
library(phonfieldwork)
df <- read_from_folder(path = "../eaffiles/", type = "eaf")
#writexl::write_xlsx(df, "eaffiles.xlsx")

# --------------------------------------------------------------------------
library(tidyverse)
# 2 check what kind of data is in each tier  
df %>% 
  group_by(tier_name, tier_type) %>% 
  mutate(count = n()) %>% 
  sample_n(1) %>% 
  arrange(-count) %>%
  View()
#  write_csv("test.csv", na = "")
  
# extract phrases and annotate language
library(cld2)
df %>% 
  filter(tier_type == "Phrases",
         content != "") %>% 
  mutate(linguist = str_detect(tier_name, "Jean_"),
         language = detect_language(content),
         language = ifelse(language %in% c("en", "fr"),
                           language,
                           "va"))->
  df_for_lang_annotate

write_csv(df_for_lang_annotate, "df_for_lang_annotate.csv", na = "")
writexl::write_xlsx(df_for_lang_annotate, "df_for_lang_annotate.xlsx")
