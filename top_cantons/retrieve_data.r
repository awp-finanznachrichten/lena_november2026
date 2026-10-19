
#import_data <- googlesheets4::read_sheet("",
 #                                        sheet = 2)


kanton_wappen_raw <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/11ubsMMA94G-aRhz7e3mganRLKzqEzfK1UgJ4e2h-RNE/edit?gid=0#gid=0") %>%
  select(Canton,Wappen)

vorlagen_names <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1SlciJa6mBxu4v2hslNfhTW7Z9xolDUCQPGkR1RpwHh0/edit?gid=1093738023#gid=1093738023")


