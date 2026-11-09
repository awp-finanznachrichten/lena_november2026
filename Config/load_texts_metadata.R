#Load Texts LENA
excel_sheets <- excel_sheets(paste0("Texte/Textbausteine_LENA_",abstimmung_date,".xlsx"))

#Votes Metadata
mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, paste0("SELECT * FROM votes_metadata WHERE date = '",voting_date,"'"))
votes_metadata <- DBI::fetch(rs,n=-1)
dbDisconnectAll()

votes_metadata_CH <- votes_metadata %>%
  filter(area_ID == "CH")

#Metadaten Gemeinden und Kantone
mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, "SELECT * FROM communities_metadata")
meta_gmd_kt <- DBI::fetch(rs,n=-1)
dbDisconnectAll()

meta_gmd_kt <- meta_gmd_kt %>%
  select(-created,-last_update)

mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, "SELECT * FROM cantons_metadata WHERE area_type = 'canton'")
meta_kt <- DBI::fetch(rs,n=-1)
dbDisconnectAll()

cantons_overview <- meta_kt %>%
  select(area_ID,languages)

mail_cantons <- meta_kt %>%
  select(area_ID,mail_KeySDA)

#Datawrapper-Codes
mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, paste0("SELECT * FROM datawrapper_codes WHERE date = '",voting_date,"'"))
datawrapper_codes <- DBI::fetch(rs,n=-1)
dbDisconnectAll()

datawrapper_auth(Sys.getenv("DW_KEY"), overwrite = TRUE)

###Historical Data (if available)
DATA_SOURCES_HIST <- c("sd-t-17-02-20240303-eidgAbstimmung.json",
                       "sd-t-17-02-20260308-eidgAbstimmung.json")
LEVEL_VOTING_HIST <- c(1,6)

data_hist_all <- list()
for (d in 1:length(DATA_SOURCES_HIST)) {
data_hist <- fromJSON(paste0("./Data/",DATA_SOURCES_HIST[d]), flatten = TRUE)
data_hist <- get_results(data_hist,LEVEL_VOTING_HIST[d],level="communal")
data_hist <- data_hist %>%
  select(Gemeinde_Nr,
         Hist_Ja_Stimmen_In_Prozent = jaStimmenInProzent,
         Hist_Ja_Stimmen_Absolut = jaStimmenAbsolut,
         Hist_Nein_Stimmen_Absolut = neinStimmenAbsolut) %>%
  mutate(Hist_Nein_Stimmen_In_Prozent = 100 - Hist_Ja_Stimmen_In_Prozent)
data_hist <- na.omit(data_hist)
data_hist_all[[d]] <- data_hist
}
