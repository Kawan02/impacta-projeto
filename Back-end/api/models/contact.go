package models

type Contact struct {
	ID               uint   `json:"id" gorm:"primary_key"`
	Nome             string `json:"nome,omitempty" gorm:"unique;not null" validate:"required"`
	Sobrenome        string `json:"sobrenome,omitempty"`
	DataDeNascimento string `json:"dtaNascimento,omitempty"`
	Telephone        string `json:"telephone,omitempty" gorm:"unique;not null" validate:"required"`
	Notas            string `json:"nota,omitempty"`
	Image            string `json:"image,omitempty"`
	Amigos           string `json:"amigo,omitempty"`
	CreatedAt        string `json:"createdAt,omitempty"`
	UpdateAt         string `json:"updateAt,omitempty"`
	Favorito         bool   `json:"favorito,omitempty"`
}
