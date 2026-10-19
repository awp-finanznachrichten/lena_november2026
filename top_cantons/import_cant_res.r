##importer res. cantonaux

link <- "https://ogd-static.voteinfo-app.ch/v1/ogd/sd-t-17-02-20260927-eidgAbstimmung.json"

vot_raw <- jsonlite::fromJSON(link)


##issue list

issues_nr <- vot_raw$schweiz$vorlagen$vorlagenId

issues_list_fr <- vot_raw$schweiz$vorlagen$vorlagenTitel %>%
  purrr::pluck() %>%
  dplyr::bind_rows() %>%
  dplyr::filter(langKey == "fr") %>%
  dplyr::pull(text)

issues <- vot_raw$schweiz$vorlagen$vorlagenTitel %>%
  purrr::pluck() %>%
  dplyr::bind_rows() %>%
  dplyr::filter(langKey == "fr")


  
mapping_issues <- vot_raw$schweiz$vorlagen %>%
  purrr::pluck() %>%
  dplyr::bind_rows() %>%
  group_by(vorlagenId) %>%
  #mutate(vorlagenId = case_when(vorlagenId == 6780 ~ 6800, #a supprimer! 6821,6822,6830,6840,6850
   #                             vorlagenId == 6790 ~ 6810)) %>% #a supprimer
  mutate(issue_number = case_when(vorlagenId == 6880 ~ 1,
                                  vorlagenId == 6890 ~ 2)) %>%
  tidyr::unnest(vorlagenTitel) %>%
  dplyr::left_join(vorlagen_names, join_by("vorlagenId" == "Vorlage_ID")) %>%
  select(vorlagenId,langKey, issue_number, text,Vorlage_f, Vorlage_d, Vorlage_i)
  
#mapping_issues <- vot_raw$schweiz$vorlagen$vorlagenTitel %>%
 # purrr::pluck() %>%
  #dplyr::bind_rows()


#%>%
 # dplyr::group_by(langKey) %>%
#  dplyr::mutate(issue_number = dplyr::row_number()) %>%
 # tidyr::pivot_wider(names_from = langKey,
                    # values_from = text)


  
cant_link <- "https://raw.githubusercontent.com/awp-finanznachrichten/lena_juni2026/refs/heads/master/Output_Switzerland/CH_Zivildienst_all_data.csv"


cant_names <- readr::read_csv(cant_link) %>%
  dplyr::group_by(Kantons_Nr) %>%
  dplyr::slice(1) %>%
  dplyr::select(Kantons_Nr,Kanton_d,Kanton_f,Kanton_i) %>%
  left_join(kanton_wappen_raw, join_by("Kanton_f" == "Canton"))



cant <- vot_raw$schweiz$vorlagen$kantone %>%
  purrr::pluck() %>%
  dplyr::bind_rows() %>%
  dplyr::group_by(geoLevelname) %>%
  dplyr::mutate(
    issue_number = dplyr::row_number(),
    issue = dplyr::case_when( #adapter au nombre de votation
      issue_number == 1 ~ issues_list_fr[1],
      issue_number == 2 ~ issues_list_fr[2]
    )
  ) %>%
  tidyr::unnest(resultat) %>%
  dplyr::filter(gebietAusgezaehlt) %>%
  dplyr::mutate(geoLevelnummer = as.numeric(geoLevelnummer),
                jaStimmenInProzent = round(jaStimmenInProzent,2)) %>%
  dplyr::rename(cantonJaStimmenInProzent = jaStimmenInProzent,
                canton_name = geoLevelname) %>%
  dplyr::mutate(cantonNoStimmenInProzent = 100-cantonJaStimmenInProzent) %>%
  dplyr::ungroup() %>%
  dplyr::select(geoLevelnummer,canton_name,issue_number,cantonJaStimmenInProzent,cantonNoStimmenInProzent,issue) %>%
  dplyr::select(geoLevelnummer,canton_name,issue_number, cantonJaStimmenInProzent,cantonNoStimmenInProzent) %>%
  dplyr::left_join(cant_names, by = c("geoLevelnummer" = "Kantons_Nr")) %>%
  dplyr::rename(name = canton_name) %>%
  dplyr::left_join(mapping_issues, by = c("issue_number" = "issue_number")) %>%
  filter(langKey == "fr",
         issue_number !=3) 

#glimpse(cant)

#set.seed(123)  # optionnel : pour reproductibilité

#cant_test <- cant %>%
#  dplyr::mutate(
#    cantonJaStimmenInProzent = round(runif(n(), 0, 100), 1),
#    cantonNoStimmenInProzent = round(runif(n(), 0, 100), 1)
#  )

#glimpse(cant_test)

#cant <- cant_test
