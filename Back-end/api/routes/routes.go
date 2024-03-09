package routes

import (
	"github.com/kawan02/handlers"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func Routes() {
	route := echo.New()

	// Middleware
	route.Use(middleware.Logger())
	route.Use(middleware.Recover())
	route.Use(middleware.CORS())

	route.GET("/contacts", handlers.FindContacts)
	route.POST("/contacts", handlers.CreateContact)
	route.PUT("/contact/:id", handlers.UpdateContact)

	route.Logger.Fatal(route.Start(":8080"))
}
