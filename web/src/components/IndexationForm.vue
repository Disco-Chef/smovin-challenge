<template>
    <form id="indexation-form" @submit.prevent="trySubmit" >
      <div class="form-group">
        <label>Region</label>
        <input type="text" v-model="formParams.region" />
      </div>
      <div class="form-group">
        <label>Rent</label>
        <input type="text" v-model="formParams.baseRent" />
      </div>
      <div class="form-group">
        <label>Contract Signed On</label>
        <Datepicker v-model="formParams.signedOn" :format="'yyyy/MM/dd'" :autoApply="true"></Datepicker>
      </div>
      <div class="form-group">
        <label>Rent Started On</label>
        <Datepicker v-model="formParams.startDate" :format="'yyyy/MM/dd'" :autoApply="true"></Datepicker>
      </div>
      <button>Get new indexed rent!</button>
    </form>
</template>

<script>
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
  name: 'IndexationForm',
  data () {
    return {
      submitting: false,
      formParams: {
        baseRent: '',
        region: '',
        signedOn: '',
        startDate: '',
      }
      // errors: {
      //   // TK: This smells.. 🤢
      //   baseRent: {
      //     missing: false
      //   },
      //   region: {
      //     missing: false,
      //     notInChoices: false
      //   },
      //   startDate: {
      //     missing: false,
      //     isInFuture: false,
      //     isBeforeSignedOn: false
      //   },
      //   signedOn: {
      //     missing: false,
      //     isInFuture: false,
      //     isAfterStartDate: false
      //   }
      // }
    }
  },
  methods: {
    trySubmit() {
      this.submitting = true

      if (this.formIsInvalid) {
        return
      }

      this.convertDateObjectToRequiredStringFormat()

      console.log(this.formParams)
    },
    convertDateObjectToRequiredStringFormat() {
      this.formParams.signedOn = this.formParams.signedOn.toISOString().split('T')[0]
      this.formParams.startDate = this.formParams.startDate.toISOString().split('T')[0]
    }
  },
  components: {
    Datepicker
  },
  computed: {
    missingBaseRent() {
      return this.formParams.baseRent === ''
    },
    missingRegion() {
      return this.formParams.region === ''
    },
    missingSignedOn() {
      return this.formParams.signedOn === ''
    },
    missingStartDate() {
      return this.formParams.startDate === ''
    },
    startDateIsInFuture() {
      return this.formParams.startDate > Date.today
    },
    signedOnIsInFuture() {
      return this.formParams.signedOn > Date.today
    },
    startBeforeSign() {
      return this.formParams.startDate < this.formParams.signedOn
    },
    negativeBaseRent() {
      return Number.isInteger(parseInt(this.baseRent))
    },
    invalidRegion() {
      return !["brussels", "Brussels", "flanders", "Flanders", "wallonia", "Wallonia"].includes(this.formParams.region)
    },
    formIsInvalid() {
      return this.missingBaseRent                     ||
             this.missingRegion                       ||
             this.missingSignedOn                     ||
             this.missingStartDate                    ||
             this.startDateIsInFuture ||
             this.signedOnIsInFuture  ||
             this.startBeforeSign                     ||
             this.negativeBaseRent                    ||
             this.invalidRegion
    }
  }
}
</script>

<style scoped>
  .form-group {
    display: flex;
    flex-direction: column;
    text-align: center;
    font-size: 32px;
    width: 400px;
  }
  label {
    width: 100%;
    height: 40px;
  }
  input {
    width: 400px;
    height: 35px;
  }
  input::placeholder {
    color: red;
  }
</style>
