import React, { useState, useEffect } from 'react'
import {
  SelectInput,
  TextInput,
  Checkbox
}             from '../Commons/inputs'
import Address from './address'

export default props => {
  const { onChange, id, data: { client, carer, currentDistricts, currentCommunes, currentVillages, currentProvinces, families } } = props

  const [sameAsClient, setSameAsClient]   = useState(false)
  const [districts, setDistricts]         = useState(currentDistricts)
  const [communes, setCommunes]           = useState(currentCommunes)
  const [villages, setVillages]           = useState(currentVillages)

  const fetchData = (parent, data, child) => {
    $.ajax({
      type: 'GET',
      url: `/api/${parent}/${data}/${child}`,
    }).success(res => {
      const dataState = { districts: setDistricts, communes: setCommunes, villages: setVillages }
      dataState[child](res.data)
    })
  }

  useEffect(() => {
    if(sameAsClient) {
      if(client.province_id !== null)
        fetchData('provinces', client.province_id, 'districts')
      if(client.district_id !== null)
        fetchData('districts', client.district_id, 'communes')
      if(client.commune_id !== null)
        fetchData('communes', client.commune_id, 'villages')
    } else {
      setDistricts([])
      setCommunes([])
      setVillages([])
    }

    const fields = {
      outside: sameAsClient ? client.outside : false,
      province_id: sameAsClient ? client.province_id : null,
      district_id: sameAsClient ? client.district_id : null,
      commune_id: sameAsClient ? client.commune_id : null,
      village_id: sameAsClient ? client.village_id : null,
      street_number: sameAsClient ? client.street_number : '',
      house_number: sameAsClient ? client.house_number : '',
      current_address: sameAsClient ? client.current_address : '',
      address_type: sameAsClient ? client.address_type : '',
      outside_address: sameAsClient ? client.outside_address : ''
    }

    onChange('carer', { ...fields })({type: 'select'})
  }, [sameAsClient, client])

  const blank = []
  const genderLists = [{label: 'Female', value: 'female'}, {label: 'Male', value: 'male'}, {label: 'Other', value: 'other'}, {label: 'Unknown', value: 'unknown'}]
  const familyLists = families.map(family => ({ label: family.name, value: family.id }))

  const onChangeFamily = ({ data, action, type }) => {
    let value = []
    if (action === 'select-option'){
      value.push(data)
    } else if (action === 'clear'){
      value = []
    }
    onChange('client', 'family_ids')({data: value, type})
  }

  return (
    <div id={id} className="collapse">
      <br/>
      <div className="row">
        <div className="col-xs-12 col-md-6 col-lg-3">
          {/* will change to carer object */}
          <TextInput label="Name" onChange={onChange('client', 'live_with')} value={client.live_with} />
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <SelectInput label="Gender" options={genderLists} onChange={onChange('carer', 'gender')} value={carer.gender}  />
        </div>
      </div>
      <div className="row">
        <div className="col-xs-12 col-md-6 col-lg-3">
          {/* will change to carer object */}
          <TextInput label="Carer Phone Number" onChange={onChange('client', 'telephone_number')} value={client.telephone_number}/>
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <TextInput label="Carer Email Address" onChange={onChange('carer', 'email')} value={carer.email} />
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <SelectInput label="Relationship to Client" options={blank} onChange={onChange('carer', 'relationship')} value={carer.relationship} />
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <SelectInput label="Family Record" options={familyLists} value={client.family_ids} onChange={onChangeFamily} />
        </div>
      </div>
      <legend>
        <div className="row">
          <div className="col-xs-12 col-md-6 col-lg-3">
            <p>Address</p>
          </div>
          {
            !carer.outside &&
            <div className="col-xs-12 col-md-6 col-lg-3">
              <Checkbox label="Same as Client" checked={sameAsClient} onChange={({data}) => setSameAsClient(data)} />
            </div>
          }
          {
            !sameAsClient &&
            <div className="col-xs-12 col-md-6 col-lg-3">
              <Checkbox label="Outside Cambodia" checked={carer.outside || false} onChange={onChange('carer', 'outside')} />
            </div>
          }
        </div>
      </legend>
      <Address sameAsClient={sameAsClient} outside={carer.outside || false} onChange={onChange} data={{client, currentDistricts: districts, currentCommunes: communes, currentVillages: villages, currentProvinces, objectKey: 'carer', objectData: carer}} />
    </div>
  )
}
