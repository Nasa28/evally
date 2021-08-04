import { Model, List } from './base'

class Organization extends Model {
  get defaults() {
    return {
      id: null,
      name: ''
    }
  }
}

class OrganizationsList extends List {
  get model() {
    return Organization
  }
}

export { Organization, OrganizationsList }
