rankhospital <- function(state, outcome, num = 1) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
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
  koef <- 1
  if (num =="best") num <- 1
  if (num =="worst") {
    koef <- -1
    num <- 1
  }
  
  if (outcome == "heart attack") ID <- 11
  if (outcome == "heart failure") ID <- 17
  if (outcome == "pneumonia") ID <- 23
  
  stateColName <- names(outcome_db)[7]
  outcomeColName <- names(outcome_db)[ID]
  
  setkeyv(outcome_db, outcomeColName)
  outcome_db <- outcome_db[!"Not Available"]
  
  
  
  tmp <- outcome_db[,suppressWarnings(as.numeric(unlist(.SD))), .SDcols=ID]
  outcome_db[,names(outcome_db)[ID]:= tmp]
  
  outcome_db <- setorderv(outcome_db, outcomeColName, order = koef, na.last = TRUE)
  
  
  
  
  minimal <- as.numeric(outcome_db["State" == state][num,ID, with = FALSE])
  
  condition <- list (minimal, state)
  
  setkeyv(outcome_db, c(outcomeColName,stateColName))
  
  return( as.character(setorder(outcome_db[condition], "Hospital Name")[1,2, with = FALSE]))
  
  
  
}