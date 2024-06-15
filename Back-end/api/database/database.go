package database

import (
	"log"

	"github.com/kawan02/models"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	dsn := "host=localhost user=postgres password=postgresql dbname=postgres port=5432"

	database, err := gorm.Open(postgres.Open(dsn))

	if err != nil {
		log.Panic("Falha ao conectar no banco de dados.", err.Error())
	}

	err = database.AutoMigrate(&models.Contact{})
	if err != nil {
		return
	}

	DB = database

}
