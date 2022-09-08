import { useState } from "react";
import Modal, { ModalBody, ModalFooter } from '../Modal'
import PropTypes from 'prop-types';

// Components
import Button, { SecondaryButton } from '../Button';

// Services
import { updateSubscriber } from "../../services/subscriber";

const SubscriberStatusModal = (props) => {
  const { isOpen, onSuccess, onFailure, onClose, subscriberId, status } = props;
  const [isDeleting, setIsDeleting] = useState(false)

  const onUpdate = () => {
    const payload = {
      subscribed: status === 'false'
    }

    setIsDeleting(true)
    updateSubscriber(subscriberId, payload)
    .then((payload) => {
      const msg = payload?.data?.message
      onSuccess(msg)
    })
    .catch((payload) => {
      const errors = payload?.response?.data?.message?.errors || []
      const error = errors.length > 0 ? errors.map(e => e.detail).join('\n') : 'Something went wrong'
      onFailure(error)
      console.error(error)
    })
    .finally(() => {
      setIsDeleting(false)
    })
  }

  const modalTitleText = status === 'true' ? "Unsubscribe" : "Resubscribe"
  const messageBodyText = status === 'true' ? 
    "Are you sure you'd like to unsubscribe this subscriber?" :
    "Are you sure you'd like to resubscribe this subscriber?"
  const buttonText = status === 'true' ? "Unsubscribe" : "Resubscribe"

  return (
    <Modal modalTitle={modalTitleText} showModal={isOpen} onCloseModal={onClose}>
      <>
        <ModalBody>
          {messageBodyText}
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="mx-2"
            onClick={onClose}
          >
            Cancel
          </SecondaryButton>
          <Button
            type="primary"
            loading={isDeleting}
            onClick={onUpdate}
          >
            {buttonText}
          </Button>
        </ModalFooter>
      </>
    </Modal>
  );
};

SubscriberStatusModal.propTypes = {
  isOpen: PropTypes.bool,
  onClose: PropTypes.func,
  onSuccess: PropTypes.func,
  onFailure: PropTypes.func,
  subscriberId: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  status: PropTypes.string
}

export default SubscriberStatusModal;
