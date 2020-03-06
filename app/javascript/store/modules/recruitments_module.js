import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { RecruitDocument, RecruitDocumentsList } from '@models/recruit_document'

const initialState = () => ({
  recruitDocuments: new RecruitDocumentsList(),
  recruitDocument: new RecruitDocument(),
  loading: true
})

const RecruitmentsModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    recruitDocuments: state => state.recruitDocuments,
    recruitDocument: state => state.recruitDocument,
    loading: state => state.loading
  },

  mutations:{
    setLoading(state, status) {
      state.loading = status
      return state
    },
    setList(state, { recruit_documents }) {
      state.recruitDocuments = new RecruitDocumentsList(recruit_documents)
      state.loading = false
      return state
    },
    setItem(state, { recruit_document }) {
      state.recruitDocument = new RecruitDocument(recruit_document)
      state.loading = false
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      http.get(RecruitDocument.routes.recruitDocumentsPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    show({ commit }, id) {
      commit('setLoading', true)

      http.get(RecruitDocument.routes.recruitDocumentPath(id))
        .then(response => {
          commit('setItem', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitment.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
  }
}

export default RecruitmentsModule