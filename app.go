package main

import (
  "encoding/csv"
  "fmt"
  "log"
  "os"
)

func main() {

  filename, err := os.Open("QueryResults.csv")
  if err != nil { 
    panic(err) 
  }

  defer filename.Close()
  r := csv.NewReader(filename)
  lines, err := r.ReadAll()

  if err != nil {
    log.Fatalf("error reading all lines: %v", err)
  }

  title := make([]string, len(lines)-1)
  body := make([]string, len(lines)-1)

  for i, line := range lines {
    if i == 0 {
      continue
    }
    title[i-1] = line[7]
    body[i-1] = line[14]
  }

    for i, _ := range title {
      fmt.Println(title[i], body[i])
    }
}