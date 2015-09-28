rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
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
  
  outcome_db <- setorderv(outcome_db, c(outcomeColName, names(outcome_db)[2]), order = koef, na.last = TRUE)
  
  solution <- outcome_db[,.SD[num,2, with = FALSE], by=State]
  setnames(solution, c("state","hospital"))
  setcolorder(solution, c("hospital", "state"))
  
  
  return (as.data.frame(solution))
  
  
}
