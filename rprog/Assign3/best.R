best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcome_db <- fread("outcome-of-care-measures.csv")
  
  
  outcome_ref <- list ("heart attack", "heart failure",  "pneumonia")
  state_ref <- unique(outcome_db[,State])
  
  
  if(!outcome %in% outcome_ref) {
    stop("invalid outcome")
    return (NULL)
  }
  if(!state %in% state_ref) {
    stop("invalid state")
    return(NULL)
    
    }
  
  
  if (outcome == "heart attack") ID <- 11
  if (outcome == "heart failure") ID <- 17
  if (outcome == "pneumonia") ID <- 23
  
  stateColName <- names(outcome_db)[7]
  outcomeColName <- names(outcome_db)[ID]
  
  
  
  tmp <- outcome_db[,suppressWarnings(as.numeric(unlist(.SD))), .SDcols=ID]
  outcome_db[,names(outcome_db)[ID]:= tmp]
  
  
  minimal <- min(as.numeric(unlist(outcome_db["State" == state][,ID, with = FALSE])), na.rm = TRUE)
  condition <- list (minimal, state)
  
  setkeyv(outcome_db, c(outcomeColName,stateColName))
  
  return( as.character(setorder(outcome_db[condition], "Hospital Name")[,2, with = FALSE]))
  
  

  
}
  

