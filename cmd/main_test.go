package main

import (
	"bytes"
	"testing"
)

func TestGreeting(t *testing.T) {
	var buf bytes.Buffer
	err := greeting(&buf)
	if err != nil {
		t.Fatalf("greeting() error = %v, want nil", err)
	}

	got := buf.String()
	want := "Hello, World!\n"

	if got != want {
		t.Errorf("greeting() = %q, want %q", got, want)
	}
}
