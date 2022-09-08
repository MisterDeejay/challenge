import classNames from 'classnames'

export function StatusPill({ value }) {
  const status = value ? 'active' : 'inactive';

  return (
    <span
      className={
        classNames(
          "px-3 py-1 uppercase leading-wide font-bold text-xs rounded-full shadow-sm",
          status.startsWith("active") ? "bg-green-100 text-green-800" : null,
          status.startsWith("inactive") ? "bg-yellow-100 text-yellow-800" : null
        )
      }
    >
      {status}
    </span>
  );
};
