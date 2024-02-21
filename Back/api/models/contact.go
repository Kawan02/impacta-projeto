package models

import "time"

type Contact struct {
	ID               uint      `json:"id" gorm:"primary_key"`
	Nome             string    `json:"nome"`
	Sobrenome        string    `json:"sobrenome"`
	DataDeNascimento string    `json:"dtaNascimento"`
	Telephone        string    `json:"telephone"`
	Notas            string    `json:"nota"`
	Image            string    `json:"image"`
	Amigos           string    `json:"amigo"`
	CreatedAt        time.Time `json:"createdAt"`
	UpdateAt         time.Time `json:"updateAt"`
	Favorito         bool      `json:"favorito"`
}
