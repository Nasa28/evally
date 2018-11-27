import axios from 'axios'

import { Utils } from '@/lib/utils'
import { Employee, EmployeesList } from '@/models/employee'

const initialState = () => ({
  employees: new EmployeesList(),
  employee: new Employee(),
  positions: [],
  status: ''
})

const EmployeesStore = {
  namespaced: true,

  state: initialState,

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
    replace(state, employee) {
      state.employees.map( el => {
        return el.id == employee.id ? employee : el
      })
      return state
    },
    remove(state, id) {
      state.employees.remove({ id: id })
      state.employee = new Employee()
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },
  actions: {
    index(context, params) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.employees.getFetchURL(), { params: params })
          .then(response => {
            let data = Utils.modelsFromResponse(response.data.data)
            context.commit('many', data)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    create(context, employee) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.employee.getSaveURL(), employee)
          .then(response => {
            let employee = new Employee(Utils.transformModel(response.data.data))

            context.commit('push', employee)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    update(context, data) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.employee.getFetchURL(), data)
          .then(response => {
            let updated = new Employee(Utils.transformModel(response.data.data))

            context.commit('replace', updated)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    destroy(context) {
      return new Promise((resolve, reject) => {
        axios.delete(context.state.employee.getDeleteURL())
          .then(response => {
            let id = context.state.employee.id

            context.commit('remove', id)

            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    }

  }
}

export default EmployeesStore
