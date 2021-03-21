module.exports = (_data, _status, _meta) => {

    if (!_data) throw new Error("Missing _data parameter.");
    if (!_status || typeof _status !== "object") throw new Error("Missing or wrong _status parameter.");

    _meta = _meta || {};

    return {
        data: _data,
        status: _status,
        meta: _meta
    };
};
