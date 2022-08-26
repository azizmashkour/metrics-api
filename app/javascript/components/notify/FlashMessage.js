import React, { Fragment } from 'react'
import PropTypes from 'prop-types'

const FlashMessage = props => (
  <div className={`${props.statusFailed ? 'bg-red-100 border-red-300' : 'bg-green-100 border-green-300' } flex items-center px-4 border rounded`}>
    <span className={`${props.statusFailed ? 'text-red-600' : 'text-green-600'} grow font-semibold`}>
      {props.statusFailed ? '🥺' : '🎉'} {props.message}
    </span>
    <button
      className="p-2 text-lg text-gray-900 rounded-md"
      onClick={() => props.setMessage(null)}>
      &times;
    </button>
  </div>
)

FlashMessage.defaultProps = {
  statusFailed: null,
  message: null
}

FlashMessage.propTypes = {
  message: PropTypes.string,
  statusFailed: PropTypes.bool,
  setMessage: PropTypes.func
}

export default FlashMessage
