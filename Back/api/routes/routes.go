package routes

import (
	"github.com/kawan02/handlers"
	"github.com/labstack/echo/v4"
)

func Routes() {
	route := echo.New()

	route.GET("/contacts", handlers.FindContacts)
	route.POST("/contacts", handlers.CreateContact)

	route.Start(":8080")
}
