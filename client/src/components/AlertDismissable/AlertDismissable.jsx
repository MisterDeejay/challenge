import PropTypes from 'prop-types'

import Alert from 'react-bootstrap/Alert';

const AlertDismissable = (props) => {
  const { message, variant } = props

  return (message !== '' &&
    <>
      <Alert variant={variant}>
        {message}
      </Alert>
    </>
  );
}

AlertDismissable.propTypes = {
  message: PropTypes.string,
  variant: PropTypes.string
}

export default AlertDismissable
