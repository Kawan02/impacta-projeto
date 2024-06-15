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
	if err := database.DB.Order("nome").Find(&contacts).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	c.JSON(http.StatusOK, contacts)
	return nil
}

// Encontra todos os contatos favoritos
func FindContactsFavorite(c echo.Context) error {
	var contact []models.Contact

	if err := database.DB.Order("nome").Where("favorito = ?", true).Find(&contact).Error; err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{
			"Mensagem": "Nenhum contato encontrado!",
			"error":    err.Error(),
		})
	}

	c.JSON(http.StatusOK, contact)
	return nil
}

// Atualiza um contato
func UpdateContact(c echo.Context) error {

	// Obtém o modelo se existir
	var contact models.Contact

	if err := database.DB.Where("id = ?", c.Param("id")).First(&contact).Error; err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{
			"Mensagem:": "Registro não encontrado!",
			"Error:":    err.Error(),
		})
	}

	// Validar input
	if err := c.Bind(&contact); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{
			"Mensagem": "Ocorreu um erro inesperado",
			"error":    err.Error(),
		})
	}

	if err := database.DB.Save(&contact).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{
			"Mensagem:": "Ocorreu um erro ao salvar os dados no banco",
			"Error:":    err.Error(),
		})
	}

	c.JSON(http.StatusOK, echo.Map{"Contato atualizado:": contact})
	return nil

}

// DeleteContact exclui um contato
func DeleteContact(c echo.Context) error {
	var book models.Contact

	if err := database.DB.Where("id = ?", c.Param("id")).First(&book).Error; err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{
			"Mensagem": "Registro não encontrado!",
			"Error":    err.Error(),
		})

	}

	if err := database.DB.Delete(&book).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	c.JSON(http.StatusOK, nil)
	return nil
}

// DeleteContacts vai excluir todos os contatos do nosso banco de dados.
func DeleteContacts(c echo.Context) error {
	var contacts []models.Contact
	if err := database.DB.Find(&contacts).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	if err := database.DB.Delete(&contacts).Error; err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{
			"Mensagem": "Não há nenhum contato salvo",
			"Error":    err.Error(),
		})
	}
	c.JSON(http.StatusOK, nil)
	return nil
}
