<template>
  <v-form ref="form" @submit.prevent="save" class="pa-3">
    <h2 class="subtitle-1 my-3">{{ $t('components.settings.organizationForm.subtitle') }}</h2>

    <v-layout wrap row>
      <v-flex xs12 md6>
        <v-text-field
          v-model="organization.name"
          :rules="[vRequired]"
          prepend-icon="mdi-tag-outline"
          :label="$t('components.settings.organizationForm.name')"
        />
      </v-flex>
    </v-layout>

    <div class="settings__actions text-right">
      <v-btn @click="$refs.form.reset()" text>
        {{ $t('shared.buttons.reset') }}
      </v-btn>

      <v-btn type="submit" color="primary" text>
        {{ $t('shared.buttons.save') }}
      </v-btn>
    </div>
  </v-form>
</template>

<script>
import { Organization } from '@models/organization'

export default {
  name: 'OrganizationForm',
  props: {
    organization: {
      type: Organization,
      required: true
    }
  },
  methods: {
    save() {
      this.$store.dispatch('AuthenticationModule/updateOrganization', this.organization)
    }
  }
}
</script>
