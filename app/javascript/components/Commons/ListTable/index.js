import React, { useEffect, useState } from 'react'
import { reject, isEmpty, titleize } from '../../DetailCall/helper'

export const HorizontalTable = ({ title, data, renderItem }) => {

  return (
    <div className='col-sm-12'>
      <div className="ibox">
        <Header 
          title={title}
        />

        <div className="ibox-content">
          <div className="row">
            <div className="col-sm-12 first-table">
              <table className="table table-bordered">
                <tbody>
                  {
                    Object.keys(reject(data)).map((key, i) => renderItem ? renderItem(data, key) : "")
                  }
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

const Header = ({title}) => (
  <div className="ibox-title">
    <h5>{title}</h5>
    <div className="ibox-tools">
      <a className="collapse-link">
        <div className="btn btn-outline btn-primary">
          <i className="fa fa-chevron-up"></i>
        </div>
      </a>
    </div>
  </div>
)

export const VerticalTable = ({ title, data, renderItem, columns }) => {

  return (
    <div className='col-sm-12'>
      <div className="ibox">
        <Header 
          title={title}
        />

        <div className="ibox-content">
          <div className="row">
            <div className="col-sm-12 first-table">
              <table className="table table-bordered">
                <thead>
                  <tr>
                    {
                      data && data[0] && columns.map(key => <th key={key} scope="col">{titleize(key)}</th>)
                    }
                  </tr>
                </thead>
                <tbody>
                  {
                    data.map((obj, i) => {
                      return (
                        isEmpty(Object.values(obj)) && data.length == 1 
                        ?
                          <tr key={`${i}`}>
                            <td className="spacing-first-col" colspan={Object.keys(obj).length}>
                              No Client
                            </td>
                          </tr>
                        :
                          <tr key={`${i}`}>
                            {
                              columns.map(key => {
                                return (
                                  <td 
                                    style={{cursor: 'pointer'}}
                                    key={key} 
                                    className="spacing-first-col" 
                                    data-href={`/clients/${obj['slug']}`} 
                                    onClick={(e) => {
                                      window.open(e.target.getAttribute('data-href'), "_blank")
                                    }}
                                  >
                                    {obj[key]}
                                  </td>
                                )
                              })
                            }
                          </tr>
                      )

                    })
                  }
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}