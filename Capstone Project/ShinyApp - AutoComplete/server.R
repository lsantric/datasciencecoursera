library(shinythemes)
library(shiny)
library(tm)
library(stringr)
library(markdown)
library(stylo)
library(data.table)


biData <- fread("./data/biData.csv")
triData <- fread("./data/triData.csv")
quadData <- fread("./data/quadData.csv")

setkey(biData, unigram)
setkeyv(triData, c("unigram", "bigram"))
setkeyv(quadData, c("unigram", "bigram", "trigram"))

shinyServer(function(input, output) {
        wordPrediction <- reactive({
                text <- input$text
                textInput <- filterInput(text)
                wordNum <- length(textInput)
                wordPrediction <- getNextWord(wordNum,textInput)})
        
        output$wordPred <- renderPrint(wordPrediction())
        output$inputWords <- renderText({ input$text }, quoted = FALSE)
})

filterInput <- function(text){
        
        filteredText <- tolower(text)
        filteredText <- removePunctuation(filteredText)
        filteredText <- removeNumbers(filteredText)
        filteredText <- str_replace_all(filteredText, "[^[:alnum:]]", " ")
        filteredText <- stripWhitespace(filteredText)
        filteredText <- txt.to.words.ext(filteredText, 
                                      language="English.all", 
                                      preserve.case = TRUE)
        
        return(filteredText)
}

getNextWord <- function(wordNum,textInput){
  
  quadFlag = FALSE
  triFlag = FALSE
  biFlag = FALSE
  
  wordPrediction <- NA
  
  if (wordNum >= 3) {
      textInput <- textInput[(wordNum - 2) : wordNum]
      
      mask <- quadData[as.list(textInput)]
      setorder(mask, -frequency)
      quadFlag <- !is.na(mask[1, frequency])
      
      if (quadFlag) {
        
        wordPrediction <- as.character(mask[1, quadgram])
      }
      
  } 
  
  if (!quadFlag & wordNum >= 2) {

     textInput <- textInput[(wordNum - 1) : wordNum]
     
     mask <- triData[as.list(textInput)]
     setorder(mask, -frequency)
     triFlag <- !is.na(mask[1, frequency])
     
     if (triFlag) {
       
       wordPrediction <- as.character(mask[1, trigram])
     }
     
  } 
  
if (!quadFlag & !triFlag & wordNum >= 1) {
     
    textInput <- textInput[wordNum]
    
    mask <- biData[as.list(textInput)]
    setorder(mask, -frequency)
    biFlag <- !is.na(mask[1, frequency])

    if (biFlag) {

        wordPrediction <- as.character(mask[1, bigram])
    }

}
  
  print(wordPrediction)
  
}
