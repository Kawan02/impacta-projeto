package handlers

import (
	"net/http"

	"github.com/kawan02/database"
	"github.com/kawan02/models"
	"github.com/labstack/echo/v4"
)

func CreateContact(c echo.Context) error {
	// Valida input
	var inputContact models.CreateContactInput

	// Valida o corpo da solicitação se os dados forem inválidos, ele retornará um erro 400
	if err := c.Bind(&inputContact); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{
			"Mensagem": "Ocorreu um erro inesperado",
			"Error":    err.Error(),
		})
	}

	// Cria um contato
	contact := models.Contact{
		Nome:             inputContact.Nome,
		Sobrenome:        inputContact.Sobrenome,
		Telephone:        inputContact.Telephone,
		Image:            inputContact.Image,
		CreatedAt:        inputContact.CreatedAt,
		Favorito:         inputContact.Favorito,
		DataDeNascimento: inputContact.DataDeNascimento,
		Notas:            inputContact.Notas,
		Amigos:           inputContact.Amigos,
	}

	//Create --> cria um contato
	if err := database.DB.Create(&contact).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	c.JSON(http.StatusOK, echo.Map{"Contato criado com sucesso!": contact})
	return nil
}

// FindContacts retornará todos os contatos do nosso banco de dados.
func FindContacts(c echo.Context) error {
	var contacts []models.Contact
	if err := database.DB.Find(&contacts).Order("nome").Error; err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	c.JSON(http.StatusOK, contacts)
	return nil
}
