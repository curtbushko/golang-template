package main

import (
	"fmt"
	"io"
	"os"
)

func greeting(w io.Writer) error {
	_, err := fmt.Fprintln(w, "Hello, World!")
	return err
}

func main() {
	if err := greeting(os.Stdout); err != nil {
		os.Exit(1)
	}
}
