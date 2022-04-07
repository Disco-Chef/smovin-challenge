<template>
  <ResultCard v-if="successfulCall" :newRentData="newRentData"  @new-indexation="startNewIndexation" />
  <IndexationForm v-else @give-valid-params-for-call:formParams="callIndexator" />
</template>

<script>
import IndexationForm from './components/IndexationForm.vue';
import ResultCard from './components/ResultCard.vue';

export default {
  name: 'App',
  data() {
    return {
      successfulCall: false,
      newRentData: {}
    };
  },
  components: {
    IndexationForm,
    ResultCard
  },
  emits: {
    formParams: {},
  },
  methods: {
    async callIndexator(formParams) {
      try {
        const response = await fetch('http://localhost:4567/v1/indexations', {
          method: 'POST',
          body: JSON.stringify(formParams),
          headers: { 'Content-Type': 'application/json' },
        });
        const data = await response.json();
        this.newRentData = {
          baseRent: formParams.base_rent,
          newRent: data.new_rent,
          baseIndex: data.base_index,
          currentIndex: data.current_index
        };

        this.successfulCall = true;
      } catch (error) {
        console.error(error);
      }
    },
    startNewIndexation() {
      this.$confetti.stop();
      this.successfulCall = false
    }
  }
}
</script>

<style>
  #app {
    margin-top: 35px;
    display: flex;
    justify-content: center;
  }
  body {
    text-align: center;
    background-color: lightblue;
    display: flex;
    justify-content: center;
  }
</style>
