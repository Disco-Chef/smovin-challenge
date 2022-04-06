<template>
  <ResultCard v-if="successfulCall" />
  <IndexationForm v-else />
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
      successfulCall: false
    }
  }
}
</script>

<style>

</style>
