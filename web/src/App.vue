<template>
  <ResultCard v-if="successfulCall" v-bind:newRentData="newRentData" />
  <IndexationForm v-else @give-valid-params-for-call:formParams="callIndexator" />
</template>

<script>
import IndexationForm from './components/IndexationForm.vue'
import ResultCard from './components/ResultCard.vue'

export default {
  name: 'App',
  components: {
    IndexationForm,
    ResultCard
  },
  data() {
    return {
      successfulCall: false,
      newRentData: {}
    }
  },
  emits: {
    formParams: {},
  },
  methods: {
    async callIndexator(formParams) {
      try {
        console.log(formParams)
        const response = await fetch('http://localhost:4567/v1/indexations', {
          method: 'POST',
          body: JSON.stringify(formParams),
          headers: { 'Content-type': 'application/json' },
        })
        const data = await response.json()
        console.log('THIS IS DATA')
        console.log(data)
        this.newRentData = {
          base_rent: formParams.base_rent,
          new_rent: data.new_rent,
          base_index: data.base_index,
          current_index: data.current_index
        }
        console.log('opa')
        console.log(this.newRentData)
        this.successfulCall = true
      } catch (error) {
        console.error(error)
      }
    }
  }
}
</script>

<style>

</style>
