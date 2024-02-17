package models

import "time"

type Contact struct {
	ID        uint      `json:"id" gorm:"primary_key"`
	Nome      string    `json:"nome"`
	Sobrenome string    `json:"sobrenome"`
	Telephone string    `json:"telephone"`
	Image     string    `json:"image"`
	CreatedAt time.Time `json:"createdAt"`
	Favorite  bool      `json:"favorite"`
	Sexo      string    `json:"sexo"`
}
