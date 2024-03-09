package main

import (
	"github.com/kawan02/database"
	"github.com/kawan02/routes"
)

func main() {
	database.ConnectDatabase()

	routes.Routes()
}
