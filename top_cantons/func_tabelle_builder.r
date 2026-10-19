generate_table <- function(language_col, canton_label, ja_label, nein_label, sheet_name) {
  # Vérification de la colonne de langue
  if (!language_col %in% c("Kanton_d", "Kanton_f", "Kanton_i")) {
    stop("La colonne de langue spécifiée n'est pas valide. Utilisez 'Kanton_d', 'Kanton_f' ou 'Kanton_i'.")
  }
  
  # Sélectionner la colonne de Vorlage en fonction de la langue
  vorlage_col <- switch(
    language_col,
    "Kanton_d" = "Vorlage_d",
    "Kanton_f" = "Vorlage_f",
    "Kanton_i" = "Vorlage_i"
  )
  
  # Récupérer les noms des issues
  issue_labels <- vorlagen_names %>%
    slice(1:2) %>%
    pull(!!sym(vorlage_col))
  
  # Fonction pour préparer les données des top et flop 3 cantons
  prepare_data <- function(issue_number) {
    top_data <- cant %>%
      filter(issue_number == !!issue_number) %>%
      arrange(desc(cantonJaStimmenInProzent)) %>%
      slice(1:3)
    
    flop_data <- cant %>%
      filter(issue_number == !!issue_number) %>%
      arrange(desc(cantonNoStimmenInProzent)) %>%
      slice(1:3)
    
    bind_rows(top_data, flop_data) %>%
      select(!!rlang::sym(language_col), Wappen, cantonJaStimmenInProzent, cantonNoStimmenInProzent) %>%
      rename_with(~ c(canton_label, "_", ja_label, nein_label))
  }
  
  # Préparer les données pour les deux issues
  data_1 <- prepare_data(1)
  data_2 <- prepare_data(2)
  
  # Fusionner les deux dataframes
  final_data <- bind_rows(data_1, data_2)
  
  # Remplacer certaines valeurs par NA pour la mise en forme
  final_data[1:3, nein_label] <- NA
  final_data[7:9, nein_label] <- NA
  final_data[4:6, ja_label] <- NA
  final_data[10:12, ja_label] <- NA
  
  # Ajouter une ligne avec les labels des issues avant chaque bloc de résultats
  final_data <- final_data %>%
    add_row(!!rlang::sym(canton_label) := issue_labels[1], .before = 1) %>%
    add_row(!!rlang::sym(canton_label) := issue_labels[2], .before = 8)
  
  # Duplication des colonnes pour le français et l'italien
  if (language_col == "Kanton_f") {
    final_data <- final_data %>%
      mutate(Oui = .data[[ja_label]], Non = .data[[nein_label]])
  } else if (language_col == "Kanton_i") {
    final_data <- final_data %>%
      mutate(Si = .data[[ja_label]], No = .data[[nein_label]])
  }
  
  # Renommage final des colonnes selon la langue
  final_data <- final_data %>%
    rename_with(~ case_when(
      language_col == "Kanton_d" ~ c("Kanton", "_", "Ja", "Nein"),
      language_col == "Kanton_f" ~ c("Canton", "_", "Oui", "Non"),
      language_col == "Kanton_i" ~ c("Cantone", "_", "Si", "No")
    ))
  
  # Écriture dans Google Sheets
  googlesheets4::sheet_write(
    final_data,
    ss = "1xjv-6Qf5MQ-ENrp6BDEHgjtEORMxDcXP-B01FtBgxKM",
    sheet = sheet_name
  )
}

generate_table("Kanton_d", "Kanton", "Ja", "Nein", "top_cantons_de")
generate_table("Kanton_f", "Canton", "Oui", "Non", "top_cantons_fr")
generate_table("Kanton_i", "Cantone", "Si", "No", "top_cantons_it")
