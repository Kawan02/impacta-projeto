package models

import "time"

type UpdateContactInput struct {
	Nome             string    `json:"nome" binding:"required"`
	Sobrenome        string    `json:"sobrenome" binding:"required"`
	DataDeNascimento string    `json:"dtaNascimento" binding:"required"`
	Notas            string    `json:"nota" binding:"required"`
	Telephone        string    `json:"telephone" binding:"required"`
	Image            string    `json:"image" binding:"required"`
	Amigos           string    `json:"amigo" binding:"required"`
	UpdateAt         time.Time `json:"updateAt" binding:"required"`
	Favorito         bool      `json:"favorito" binding:"required"`
}
