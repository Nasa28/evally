import axios from 'axios'

import { Utils } from '../../lib/utils'
import { Employee, EmployeesList } from '../../models/employee'

const EmployeesStore = {
  namespaced: true,
  state: {
    employees: new EmployeesList(),
    employee: new Employee(),
    positions: [],
    status: ''

  },
  getters: {
    employees: state => state.employees,
    employee: state => state.employee,
    positions: state => state.positions,
    status: state => state.status

  },
  mutations: {
    clear(state) {
      state.employee = new Employee()
      return state
    },
    one(state, employee_id) {
      state.employee = state.employees.find({ id: employee_id })
      return state
    },
    many(state, data) {
      state.employees.replace(data)
      state.positions = Utils.collectPositions(data)
      state.status = 'ok'
      return state
    },
    push(state, data) {
      state.employees.add(data)
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    },

  },
  actions: {
    index(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.employees.getFetchURL())
          .then( response => {
            let data = Utils.modelsFromResponse(response.data.data)
            context.commit('many', data)
          })
          .catch( error => {
            reject(error)
          })
      })
    },
    create(context, employee) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.employee.getSaveURL(), employee.attributes)
          .then( response => {
            let employee = new Employee(Utils.transformModel(response.data.data))

            context.commit('push', employee)

            resolve(response)
          })
          .catch( error => {
            reject(error)
          })
      })
    },

  }
}

export default EmployeesStore
