@SuppressWarnings('PMD.AvoidGlobalModifier, PMD.FieldNamingConventions')
@JsonAccess(serializable='always' deserializable='always')
global class PetstoreApiV1Order {
  global Long id;
  global Long petId;
  global Integer quantity;
  global Datetime shipDate;
  global String status;
  global Boolean complete;
  global Long getId() {
    return this.id;
  }

  global PetstoreApiV1Order setId(final Long id) {
    this.id = id;
    return this;
  }

  global Long getPetId() {
    return this.petId;
  }

  global PetstoreApiV1Order setPetId(final Long petId) {
    this.petId = petId;
    return this;
  }

  global Integer getQuantity() {
    return this.quantity;
  }

  global PetstoreApiV1Order setQuantity(final Integer quantity) {
    this.quantity = quantity;
    return this;
  }

  global Datetime getShipDate() {
    return this.shipDate;
  }

  global PetstoreApiV1Order setShipDate(final Datetime shipDate) {
    this.shipDate = shipDate;
    return this;
  }

  global String getStatus() {
    return this.status;
  }

  global PetstoreApiV1Order setStatus(final String status) {
    this.status = status;
    return this;
  }

  global Boolean getComplete() {
    return this.complete;
  }

  global PetstoreApiV1Order setComplete(final Boolean complete) {
    this.complete = complete;
    return this;
  }

}
