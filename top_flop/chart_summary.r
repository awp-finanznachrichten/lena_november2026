
manual_chart_ids <-  c(
  # FR
  "c76ol","m0RIF",
  "Fh5jl","u1LWo",
  
  # DE
  "qpAKw","7wRiY",
  "pIfGc","v6jnq",
  
  
  # IT
  "zoSB0","rFsC9",
  "ctDyD","ZH94w",
  
  ##kanton id
  "lz2ru","3AMo7","YG8ja"
)




#kantonale_id <- c("ErkU1","Nccyy","Mdi2U")



manual_chart_summary <- data.frame("",
                                   "",
                                   "",
                                   "",
                                   "",
                                   "",
                                   "",
                                   "")

manual_chart_summary <- data.frame(matrix(ncol = length(manual_chart_summary), nrow = 0))

colnames(manual_chart_summary) <- c("Typ","Vorlage","Titel","Sprache","ID","Link","Iframe","Script")


#retrive_test <- dw_retrieve_chart_metadata("Sw6RJ")

#retrive_test$content$title

for (chart_id in manual_chart_ids) {
  
  # Récupérer les métadonnées du graphique
  metadata_chart <- DatawRappr::dw_retrieve_chart_metadata(chart_id)
  
  # Créer une nouvelle entrée de métadonnées
  new_entry <- data.frame(
    "Typ" = "Top10",
    "Vorlage" = "alle",
    "Titel" = metadata_chart$content$title,
    "Sprache" = metadata_chart$content$language,
    "ID" = metadata_chart$id,
    "Link" = metadata_chart$content$publicUrl,
    "Iframe" = metadata_chart$content$metadata$publish$`embed-codes`$`embed-method-responsive`,
    "Script" = metadata_chart$content$metadata$publish$`embed-codes`$`embed-method-web-component`
  )
  
  # Ajouter la nouvelle entrée au tableau récapitulatif
  manual_chart_summary <- rbind(manual_chart_summary, new_entry)
}

manual_chart_summary <- manual_chart_summary %>%
  dplyr::mutate(date = "2026-09-27",
         Typ = dplyr::case_when(ID %in% kantonale_id ~ "Kantone",
                                TRUE ~ as.character("Top10")))

save_xlsx <- "c:/users/yove/R/selfpick/data-raw/resources/vot_fed_09_2026/top_flop_summaries.xlsx"

writexl::write_xlsx(manual_chart_summary, save_xlsx)
