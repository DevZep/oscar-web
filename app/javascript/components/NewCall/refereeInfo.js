import React, { useEffect, useState } from "react";
import { SelectInput, TextInput, Checkbox, RadioGroup } from "../Commons/inputs";
import TaskModal from './addTaskModal'
import Address from "./address";

export default props => {
  const {
    onChange,
    data: {
      clientTask,
      refereeDistricts,
      refereeCommunes,
      refereeVillages,
      referee,
      referees,
      call,
      clients,
      currentProvinces,
      referralSourceCategory,
      referralSource,
      errorFields,
      addressTypes, T
    }
  } = props;

  const client = clients[0]

  const genderLists = [
    { label: T.translate("newCall.refereeInfo.genderLists.female"), value: "female" },
    { label: T.translate("newCall.refereeInfo.genderLists.male"), value: "male" },
    { label: T.translate("newCall.refereeInfo.genderLists.other"), value: "other" },
    { label: T.translate("newCall.refereeInfo.genderLists.unknown"), value: "unknown" }
  ];

  const refereeLists = () => {
    let newList = []
    referees.forEach(r => newList.push({ label: `${r.name} ${r.phone} ${r.email}`, value: r.id }))
    return newList
  }


  const answeredCallOpts = [
    { label: T.translate("newCall.refereeInfo.answeredCallOpts.call_answered"), value: true },
    { label: T.translate("newCall.refereeInfo.answeredCallOpts.return_missed_call"), value: false }
  ];
  const ageOpts = [
    { label: T.translate("newCall.refereeInfo.ageOpts.18_plus"), value: true },
    { label: T.translate("newCall.refereeInfo.ageOpts.under_18"), value: false }
  ];
  const calledBeforeOpts = [
    { label: T.translate("newCall.refereeInfo.calledBeforeOpts.yes"), value: true },
    { label: T.translate("newCall.refereeInfo.calledBeforeOpts.no"), value: false }
  ];
  const referralSourceCategoryLists = referralSourceCategory.map(category => ({
    label: category[0],
    value: category[1]
  }));
  const referralSourceLists = referralSource
    .filter(
      source =>
        source.ancestry !== null &&
        source.ancestry == client.referral_source_category_id
    )
    .map(source => ({ label: source.name, value: source.id }));

  useEffect(() => {
    if (referee.anonymous) {
      const fields = {
        anonymous: true,
        outside: false,
        name: "Anonymous",
        phone: "",
        email: "",
        gender: "",
        street_number: "",
        house_number: "",
        current_address: "",
        outside_address: "",
        address_type: "",
        province_id: null,
        district_id: null,
        commune_id: null,
        village_id: null
      };
      onChange("referee", { ...fields })({ type: "select" });
    }
  }, [referee.anonymous]);

  useEffect(() => {
    const field = {
      referral_source_category_id: client.referral_source_category_id,
      referral_source_id: client.referral_source_id
    }
    modifyClientObject(field)
  }, [clients.length])

  const onReferralSourceCategoryChange = data => modifyClientObject({ referral_source_category_id: data.data, referral_source_id: null })
  const onReferralSourceChange = data => modifyClientObject({ referral_source_id: data.data })

  const modifyClientObject = field => {
    const newObjects = clients.map(object => {
      const newObject = { ...object, ...field }
      return newObject
    })
    onChange('client', newObjects)({type: 'object'})
  }

  const onRefereeNameChange = evt => {
    let {email, id, name, gender, phone, province_id, district_id, commune_id, village_id, street_number, house_number, address_type, current_address, outside, outside_address, adult} = referees.filter(r => r.id == evt.data)[0] || {}
    onChange("referee", {
      id,
      name,
      email,
      gender,
      phone,
      province_id,
      district_id,
      commune_id,
      village_id,
      street_number,
      house_number,
      address_type,
      current_address,
      outside,
      outside_address,
      adult
    })({ type: "select" });
  }

  const renderNameField = () => {
    if(!referee.anonymous && call.called_before) {
      return (
        <SelectInput
          T={T}
          label="Name"
          required
          isDisabled={referee.anonymous}
          options={refereeLists()}
          onChange={onRefereeNameChange}
          isError={errorFields.includes("name")}
          value={referee.id}
        />
      )
    } else {
      return (
        <TextInput
          T={T}
          required
          disabled={referee.anonymous}
          isError={errorFields.includes("name")}
          value={referee.name}
          label="Name"
          onChange={(value) => { onChange('referee', 'name')(value) }}
        />
      )
    }
  }

  return (
    <div className="containerClass">
      <TaskModal data={{referee, clientTask, call}} onChange={onChange} />

      <legend>
        <div className="row">
          <div className="col-xs-12 col-md-6">
            <p>{T.translate("newCall.refereeInfo.caller_info")}</p>
          </div>
        </div>
      </legend>

      <div className="row">
        <div className="col-xs-12">
          {/* todo: add required */}
          <RadioGroup
            inline
            required
            isError={errorFields.includes("answered_call")}
            onChange={onChange("call", "answered_call")}
            options={answeredCallOpts}
            label={T.translate("newCall.refereeInfo.did_you_answer_the_call")}
            value={call.answered_call}
          />
        </div>
      </div>
      <div className="row">
        <div className="col-xs-12">
          <RadioGroup
            inline
            required
            isError={errorFields.includes("called_before")}
            label={T.translate("newCall.refereeInfo.have_you_called")}
            options={calledBeforeOpts}
            onChange={onChange("call", "called_before")}
            value={call.called_before}
          />
        </div>
      </div>
      <div className="row">
        <div className="col-xs-12 col-sm-6 col-md-3">
          <Checkbox
            label={T.translate("newCall.refereeInfo.anonymous_referee")}
            checked={referee.anonymous || false}
            onChange={onChange("referee", "anonymous")}
          />
        </div>
      </div>
      <br />
      <div className="row">
        <div className="col-xs-12 col-md-6 col-lg-3">
          {renderNameField()}
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <SelectInput
            T={T}
            label={T.translate("newCall.refereeInfo.gender")}
            isDisabled={referee.anonymous || call.called_before}
            options={genderLists}
            onChange={onChange("referee", "gender")}
            value={referee.gender}
          />
        </div>
        <div className="col-xs-12 col-md-6">
          <RadioGroup
            inline
            label={T.translate("newCall.refereeInfo.are_you_over_18")}
            disabled={referee.anonymous || call.called_before}
            options={ageOpts}
            onChange={onChange("referee", "adult")}
            value={referee.adult}
          />
        </div>
      </div>
      <div className="row">
        <div className="col-xs-12 col-md-6 col-lg-3">
          <TextInput
            T={T}
            label={T.translate("newCall.refereeInfo.referee_phone")}
            disabled={referee.anonymous || call.called_before}
            onChange={onChange("referee", "phone")}
            value={referee.phone}
          />
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <TextInput
            T={T}
            label={T.translate("newCall.refereeInfo.referee_email")}
            disabled={referee.anonymous || call.called_before}
            onChange={onChange("referee", "email")}
            value={referee.email}
          />
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <SelectInput
            T={T}
            required
            isError={errorFields.includes("referral_source_category_id")}
            label={T.translate("newCall.refereeInfo.referral_source_catgeory")}
            options={referralSourceCategoryLists}
            value={client.referral_source_category_id}
            onChange={onReferralSourceCategoryChange}
          />
        </div>
        <div className="col-xs-12 col-md-6 col-lg-3">
          <SelectInput
            T={T}
            options={referralSourceLists}
            label={T.translate("newCall.refereeInfo.referral_source")}
            onChange={onReferralSourceChange}
            value={client.referral_source_id}
          />
        </div>
      </div>
      <legend>
        <div className="row">
          <div className="col-xs-12 col-md-6 col-lg-3">
            <p>{T.translate("newCall.refereeInfo.address")}</p>
          </div>
          {!referee.anonymous && (
            <div className="col-xs-12 col-md-6 col-lg-3">
              <Checkbox
                disabled={call.called_before}
                label={T.translate("newCall.refereeInfo.outside_cambodia")}
                checked={referee.outside || false}
                onChange={onChange("referee", "outside")}
              />
            </div>
          )}
        </div>
      </legend>
      <Address
        disabled={referee.anonymous || call.called_before}
        outside={referee.outside || false}
        onChange={onChange}
        data={{
          currentDistricts: refereeDistricts,
          currentCommunes: refereeCommunes,
          currentVillages: refereeVillages,
          currentProvinces,
          addressTypes,
          objectKey: "referee",
          objectData: referee,
          T
        }}
      />

      <div className="row">
        <div className="col-xs-12">
          <Checkbox
            label={T.translate("newCall.refereeInfo.this_caller_has_requested")}
            checked={call.requested_update || false}
            onChange={onChange("call", "requested_update")}
          />
        </div>
      </div>
    </div>
  );
};
