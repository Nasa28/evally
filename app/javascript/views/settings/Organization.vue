<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.organization.title') }}</h1>

    <v-layout wrap row>
      <v-flex xs12>
        <div v-if="loading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
        </div>

        <organization-form :organization="organization" />
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import OrganizationForm from '@components/settings/OrganizationForm'

export default {
  name: 'SettingsProfile',
  components: { OrganizationForm },
  computed: {
    ...mapState('AuthenticationModule', [
      'organization',
      'loading'
    ])
  }
}
</script>
