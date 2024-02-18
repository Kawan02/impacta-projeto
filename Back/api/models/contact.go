package models

import "time"

type Contact struct {
	ID        uint      `json:"id" gorm:"primary_key"`
	Nome      string    `json:"nome"`
	Sobrenome string    `json:"sobrenome"`
	Telephone string    `json:"telephone"`
	Image     string    `json:"image"`
	CreatedAt time.Time `json:"createdAt"`
	UpdateAt  time.Time `json:"updateAt"`
	Favorito  bool      `json:"favorito"`
	Sexo      string    `json:"sexo"`
}
