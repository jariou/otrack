fin  = "C:/Users/jariou/CS/git/cs_macros/logs/IGN_Log.sas"
fout = "C:/Users/jariou/CS/git/cs_macros/logs/IGN_Calls.sas"

leadingGood = "MPRINT("
JacksLines = readLines(fin)

Dmprint = tibble::tibble(ln = 1:length(JacksLines),
  JL = JacksLines) %>%
  dplyr::filter(., stringr::str_detect(JL,"MPRINT\\(")) %>%
  dplyr::mutate(., 
                call = stringr::str_extract(JL, "MPRINT\\([A-Za-z0-9_]*\\)"),
                call2 = stringr::str_replace(call,"MPRINT\\(",""),
                call2 = stringr::str_replace(call2,"\\)","")
                ) %>%
  dplyr::group_by(., call2) %>%
  dplyr::mutate(., 
                i = 1:n(),
                n = n()
                ) %>%
  dplyr::ungroup(.) %>%
  dplyr::filter(., i == 1) %>%
  dplyr::mutate(., request = paste0(call2," (",ln,")")) %>%
  dplyr::select(., ln, request)

Derror = tibble::tibble(ln = 1:length(JacksLines),
                        JL = JacksLines) %>%
  dplyr::filter(., stringr::str_detect(JL,"^ERROR")) %>%
  dplyr::mutate(., request = paste0("(",ln,")",  " _____ ",JL )) %>%
  dplyr::select(., ln, request)

D = rbind(Dmprint, Derror) %>%
  dplyr::arrange(., ln) %>%
  dplyr::select(., -ln)

readr::write_csv(D,fout,col_names = F)
#write.csv(x = D, file = fout, quote = F, col.names = F, row.names = F) 


