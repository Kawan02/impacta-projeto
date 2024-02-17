package models

import "time"

type CreateContactInput struct {
	Nome      string    `json:"nome" binding:"required"`
	Sobrenome string    `json:"sobrenome" binding:"required"`
	Telephone string    `json:"telephone" binding:"required"`
	Image     string    `json:"image" binding:"required"`
	CreatedAt time.Time `json:"createdAt" binding:"required"`
	Favorite  bool      `json:"favorite" binding:"required"`
	Sexo      string    `json:"sexo" binding:"required"`
}
