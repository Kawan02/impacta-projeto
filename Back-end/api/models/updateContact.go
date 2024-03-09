package models

type UpdateContactInput struct {
	Nome             string `json:"nome,omitempty" gorm:"unique;not null" validate:"required"`
	Sobrenome        string `json:"sobrenome,omitempty"`
	DataDeNascimento string `json:"dtaNascimento,omitempty"`
	Notas            string `json:"nota,omitempty"`
	Telephone        string `json:"telephone,omitempty" gorm:"unique;not null" validate:"required"`
	Image            string `json:"image,omitempty"`
	Amigos           string `json:"amigo,omitempty"`
	UpdateAt         string `json:"updateAt,omitempty" validate:"required"`
	Favorito         bool   `json:"favorito,omitempty"`
}
