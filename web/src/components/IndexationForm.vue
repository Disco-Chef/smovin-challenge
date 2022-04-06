<template>
    <form id="indexation-form" @submit.prevent="trySubmit" >
      <div class="form-group">
        <label>Region</label>
        <input type="text" v-model="formParams.region" :class="(submitting && (missingRegion || invalidRegion)) ? 'invalid-input' : '' " />
      </div>
      <div class="form-group">
        <label>Rent</label>
        <input type="text" v-model="formParams.baseRent" :class="(submitting && (missingBaseRent || negativeOrZeroBaseRent)) ? 'invalid-input' : '' " />
      </div>
      <div class="form-group">
        <label>Contract Signed On</label>
        <Datepicker v-model="formParams.signedOn" :format="'yyyy/MM/dd'" :autoApply="true" :inputClassName="(submitting && (missingSignedOn || signedOnIsInFuture || startBeforeSign)) ? 'invalid-input' : '' " />
      </div>
      <div class="form-group">
        <label>Rent Started On</label>
        <Datepicker v-model="formParams.startDate" :format="'yyyy/MM/dd'" :autoApply="true" :inputClassName="(submitting && (missingStartDate || startDateIsInFuture || startBeforeSign)) ? 'invalid-input' : '' " />
      </div>
      <button>Get new indexed rent!</button>
    </form>
    <!-- <p>Submitting: {{ submitting }} </p>
    <p>form params: {{ formParams }}</p> -->
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
    }
  },
  methods: {
    trySubmit() {
      this.submitting = true

      if (this.formIsInvalid) {
        return
      }

      this.convertNonStringsToRightType()
      this.formParams = this.formatParamsForCall(this.formParams)
      this.$emit('give-valid-params-for-call:formParams', this.formParams);
      // TK: After successful submit

      // this.resetForm()
      this.submitting = false
    },
    convertNonStringsToRightType() {
      this.formParams.baseRent = parseInt(this.formParams.baseRent)
      this.formParams.signedOn = this.formParams.signedOn.toISOString().split('T')[0]
      this.formParams.startDate = this.formParams.startDate.toISOString().split('T')[0]
    },
    resetForm() {
      this.formParams = {
        baseRent: '',
        region: '',
        signedOn: '',
        startDate: '',
      }
    },
    formatParamsForCall(formParams) {
      return {
        'base_rent': formParams.baseRent,
        'region': formParams.region.toLowerCase(),
        'signed_on': formParams.signedOn,
        'start_date': formParams.startDate
      }
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
      return this.formParams.startDate > new Date()
    },
    signedOnIsInFuture() {
      return this.formParams.signedOn > new Date()
    },
    startBeforeSign() {
      return this.formParams.startDate < this.formParams.signedOn
    },
    negativeOrZeroBaseRent() {
      return parseInt(this.formParams.baseRent) <= 0
    },
    invalidRegion() {
      return !["brussels", "Brussels", "flanders", "Flanders", "wallonia", "Wallonia"].includes(this.formParams.region)
    },
    formIsInvalid() {
      return this.missingBaseRent                     ||
             this.missingRegion                       ||
             this.missingSignedOn                     ||
             this.missingStartDate                    ||
             this.startDateIsInFuture                 ||
             this.signedOnIsInFuture                  ||
             this.startBeforeSign                     ||
             this.negativeOrZeroBaseRent                    ||
             this.invalidRegion
    }
  }
}
</script>

<style scoped>

  body {
    background-color: red;
  }
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
</style>
<style>
/* global styles */
  .invalid-input {
    border: medium solid red;
  }
</style>
